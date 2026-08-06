
#include "decode.h"

typedef enum _decode_field_sizes {
    e_magic_string_field = 2,
    e_file_extn_size_field = 4,
    e_file_size_field = 8
} decode_field_sizes;

static uint8_t filename_bmp_validate(char *filename);
static void cleanup_fp(DecodeInfo *decInfo);
static Status open_files(DecodeInfo *decInfo, uint8_t filetype);

Status do_decoding(DecodeInfo *decInfo) {
    if(open_files(decInfo, 0) == e_failure) {
        fprintf(stderr, "%s: File open failed\n", __FILE__);
        cleanup_fp(decInfo);
        return e_failure;
    }
    fprintf(stdout, "%s: File opens success\n", __FILE__);

    if(validate_magic_string(MAGIC_STRING, decInfo) == e_failure) {
        fprintf(stderr, "%s: Failed to validate magic string.\n", __FILE__);
        cleanup_fp(decInfo);
        return e_failure;
    }
    fprintf(stdout, "%s: Magic string validated successful.\n", __FILE__);

    if(decode_secret_file_extn_size(&(decInfo->size_secret_file_extn), decInfo) == e_failure) {
        fprintf(stderr, "%s: Failed to retrieve file extension size.\n", __FILE__);
        cleanup_fp(decInfo);
        return e_failure;
    }
    fprintf(stdout, "%s: File extension size retrieved successful.\n", __FILE__);

    if(decInfo->size_secret_file_extn > 0) {
        char extn[(decInfo->size_secret_file_extn) + 1];
        if(decode_secret_file_extn((uint8_t *)extn, decInfo) == e_failure) {
            fprintf(stderr, "%s: Failed to retrieve file extension.\n", __FILE__);
            cleanup_fp(decInfo);
            return e_failure;
        }
        fprintf(stdout, "%s: File extension retrieved successful.\n", __FILE__);

        extn[decInfo->size_secret_file_extn] = '\0';

        if(file_extn_correction(extn, decInfo) == e_failure) {
            fprintf(stderr, "%s: Failed to fix file extension.\n", __FILE__);
            cleanup_fp(decInfo);
            return e_failure;
        }
        fprintf(stdout, "%s: File extension is correct.\n", __FILE__);
    }
    else {
        if(file_extn_correction(NULL, decInfo) == e_failure) {
            fprintf(stderr, "%s: Failed to fix file extension.\n", __FILE__);
            cleanup_fp(decInfo);
            return e_failure;
        }
        fprintf(stdout, "%s: File extension is correct.\n", __FILE__);
    }

    if(open_files(decInfo, 1) == e_failure) {
        fprintf(stderr, "%s: File open failed\n", __FILE__);
        cleanup_fp(decInfo);
        return e_failure;
    }
    fprintf(stdout, "%s: File opens success\n", __FILE__);

    if(decode_secret_file_size(&(decInfo->size_secret_file), decInfo) == e_failure) {
        fprintf(stderr, "%s: Failed to retrieve file size.\n", __FILE__);
        cleanup_fp(decInfo);
        return e_failure;
    }
    fprintf(stdout, "%s: File size retrieved successful.\n", __FILE__);
    
    if(decode_secret_file(decInfo) == e_failure) {
        fprintf(stderr, "%s: Failed to retrieve file.\n", __FILE__);
        cleanup_fp(decInfo);
        return e_failure;
    }
    fprintf(stdout, "%s: File retrieved successful.\n", __FILE__);

    cleanup_fp(decInfo);
    return e_success;
}

Status decode_secret_file(DecodeInfo *decInfo) {
    fseek(decInfo->fptr_secret, 0, SEEK_SET);
    uint8_t buffer[FILE_READ_BLOCK_SIZE];

    size_t full_blocks = decInfo->size_secret_file / FILE_READ_BLOCK_SIZE;
    size_t rem = decInfo->size_secret_file % FILE_READ_BLOCK_SIZE;
    for(size_t i = 0; i < full_blocks; i++) {
        if(decode_image_to_data(FILE_READ_BLOCK_SIZE, decInfo->fptr_stego_image, buffer) == e_failure) {
            return e_failure;
        }
        if(fwrite(buffer, 1, FILE_READ_BLOCK_SIZE, decInfo->fptr_secret) != FILE_READ_BLOCK_SIZE) {
            return e_failure;
        }
    }
    if(rem > 0) {
        if(decode_image_to_data(rem, decInfo->fptr_stego_image, buffer) == e_failure) {
            return e_failure;
        }
        if(fwrite(buffer, 1, rem, decInfo->fptr_secret) != rem) {
            return e_failure;
        }
    }

    return e_success;
}

Status decode_secret_file_size(uint64_t *size_data, DecodeInfo *decInfo) {
    uint8_t *buffer = (uint8_t*)size_data;

    for(uint8_t i = 0; i < e_file_size_field; i++) {
        if(decode_image_to_data(1, decInfo->fptr_stego_image, &buffer[i]) == e_failure) {
            return e_failure;
        }
    }

    return e_success;
}

Status file_extn_correction(char *crct_extn, DecodeInfo *decInfo) {
    if(crct_extn == NULL) {
        char *secret_fname = decInfo->secret_fname;
        for(; *secret_fname != '\0'; secret_fname++);
        for(; *secret_fname != '.' && secret_fname != decInfo->secret_fname; secret_fname--);
        if(secret_fname == decInfo->secret_fname) {
            return e_success;
        }
        *secret_fname = '\0';
        return e_success;
    }

    char *secret_fname = decInfo->secret_fname;
    for(; *secret_fname != '\0'; secret_fname++);
    char *end_fname = secret_fname;
    for(; *secret_fname != '.' && secret_fname != decInfo->secret_fname; secret_fname--);
    if(secret_fname == decInfo->secret_fname) {
        secret_fname = end_fname;
    }

    size_t i;
    for(i = 0; i < decInfo->size_secret_file_extn; i++) {
        secret_fname[i] = crct_extn[i];
    }
    secret_fname[i] = '\0';

    return e_success;
}

Status decode_secret_file_extn(uint8_t *extn, DecodeInfo *decInfo) {
    return decode_image_to_data(decInfo->size_secret_file_extn, decInfo->fptr_stego_image, extn);
}

Status decode_secret_file_extn_size(uint *file_extn_size, DecodeInfo *decInfo)
{
    uint8_t *buffer = (uint8_t *)file_extn_size;

    for (uint8_t i = 0; i < e_file_extn_size_field; i++)
    {
        if (decode_image_to_data(1, decInfo->fptr_stego_image, &buffer[i]) == e_failure)
        {
            return e_failure;
        }
    }

    return e_success;
}

Status validate_magic_string(const char *magic_string, DecodeInfo *decInfo) {
    fseek(decInfo->fptr_stego_image, BMP_HEADER_SIZE, SEEK_SET);
    uint8_t buffer[e_magic_string_field];
    if(decode_image_to_data(e_magic_string_field, decInfo->fptr_stego_image, buffer) == e_failure) {
        return e_failure;
    }

    for(uint8_t i = 0; i < e_magic_string_field; i++) {
        if(buffer[i] != magic_string[i]) {
            return e_failure;
        }
    }

    return e_success;
}

Status decode_image_to_data(size_t target_readBytes, FILE *fptr_stego_image, uint8_t *decryptedData) {
    uint8_t buffer[IMAGE_BYTE_PER_DATA_BYTE];

    for(size_t i = 0; i < target_readBytes; i++) {
        if(fread(buffer, 1, IMAGE_BYTE_PER_DATA_BYTE, fptr_stego_image) != IMAGE_BYTE_PER_DATA_BYTE) {
            return e_failure;
        }
        if(decode_lsb_to_byte(buffer, &decryptedData[i]) == e_failure) {
            return e_failure;
        }
    }

    return e_success;
}

Status decode_lsb_to_byte(uint8_t enc_data[], uint8_t *destByte) {
    uint8_t mask = 0x01;
    *destByte = 0;
    for(uint8_t i = 0; i < IMAGE_BYTE_PER_DATA_BYTE; i++) {
        *destByte |= ((enc_data[i] & mask) << (7 - i));
    }
    return e_success;
}

static Status open_files(DecodeInfo *decInfo, uint8_t filetype)
{
    if(filetype == 1) { // Secret file
        decInfo->fptr_secret = fopen(decInfo->secret_fname, "wb");
        // Do Error handling
        if (decInfo->fptr_secret == NULL)
        {
            perror("fopen");
            fprintf(stderr, "%s: Unable to open file %s\n", __FILE__, decInfo->secret_fname);

            return e_failure;
        }
    }
    else if(filetype == 0) { // Stego Image file
        decInfo->fptr_stego_image = fopen(decInfo->stego_image_fname, "rb");
        // Do Error handling
        if (decInfo->fptr_stego_image == NULL)
        {
            perror("fopen");
            fprintf(stderr, "%s: Unable to open file %s\n", __FILE__, decInfo->stego_image_fname);

            return e_failure;
        }
    }

    // No failure return e_success
    return e_success;
}

static void cleanup_fp(DecodeInfo *decInfo) {
    if(decInfo->fptr_secret != NULL) {
        fclose(decInfo->fptr_secret);
        decInfo->fptr_secret = NULL;
    }
    if(decInfo->fptr_stego_image != NULL) {
        fclose(decInfo->fptr_stego_image);
        decInfo->fptr_stego_image = NULL;
    }
    fprintf(stdout, "%s: File pointers closed; Resource Leak Averted\n", __FILE__);
}

Status read_and_validate_decode_args(char *argv[], DecodeInfo *decInfo) {
    // Steganography Image
    if(argv[2] == NULL) {
        return e_failure;
    }
    if(filename_bmp_validate(argv[2])) {
        return e_failure;
    }
    decInfo->stego_image_fname = argv[2];

    // Output File
    if(argv[3] == NULL) {
        strcpy(decInfo->secret_fname, "decoded_msg.txt");
        return e_success;
    }
    strcpy(decInfo->secret_fname, argv[3]);

    return e_success;
}

static uint8_t filename_bmp_validate(char *filename) {
    char *letter = filename, *word = filename;

    for(; *letter != '\0'; letter++);
    for(; *letter != '.' && letter != word; letter--);

    if(letter == word) {
        return 1;
    }
    if(letter[1] != 'b' || letter[2] != 'm' || letter[3] != 'p' || letter[4] != '\0') {
        return 1;
    }

    return 0;
}

