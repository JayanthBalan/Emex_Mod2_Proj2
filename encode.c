#include <stdio.h>
#include "encode.h"

static uint8_t filename_bmp_validate(char *filename);
static void cleanup_fp(EncodeInfo *encInfo);
static Status open_files(EncodeInfo *encInfo);

typedef enum _encode_field_sizes {
    e_magic_string_field = 2,
    e_file_extn_size_field = 4,
    e_file_size_field = 8
} encode_field_sizes;

/* Function Definitions */

/* Get image size
 * Input: Image file ptr
 * Output: width * height * bytes per pixel (3 in our case)
 * Description: In BMP Image, width is stored in offset 18,
 * and height after that. size is 4 bytes
 */
uint64_t get_image_size_for_bmp(FILE *fptr_image)
{
    uint width, height;
    // Seek to 18th byte
    fseek(fptr_image, 18, SEEK_SET);

    // Read the width (an int)
    fread(&width, sizeof(int), 1, fptr_image);
    fprintf(stdout, "%s: width = %lu\n", __FILE__, width);

    // Read the height (an int)
    fread(&height, sizeof(int), 1, fptr_image);
    fprintf(stdout, "%s: height = %lu\n", __FILE__, height);

    // Return image capacity
    return (uint64_t)(width * height * 3);
}

/* 
 * Get File pointers for i/p and o/p files
 * Inputs: Src Image file, Secret file and
 * Stego Image file
 * Output: FILE pointer for above files
 * Return Value: e_success or e_failure, on file errors
 */
static Status open_files(EncodeInfo *encInfo)
{
    // Src Image file
    encInfo->fptr_src_image = fopen(encInfo->src_image_fname, "rb");
    // Do Error handling
    if (encInfo->fptr_src_image == NULL)
    {
    	perror("fopen");
    	fprintf(stderr, "%s: Unable to open file %s\n", __FILE__, encInfo->src_image_fname);

    	return e_failure;
    }

    // Secret file
    encInfo->fptr_secret = fopen(encInfo->secret_fname, "rb");
    // Do Error handling
    if (encInfo->fptr_secret == NULL)
    {
    	perror("fopen");
    	fprintf(stderr, "%s: Unable to open file %s\n", __FILE__, encInfo->secret_fname);

    	return e_failure;
    }

    // Stego Image file
    encInfo->fptr_stego_image = fopen(encInfo->stego_image_fname, "wb");
    // Do Error handling
    if (encInfo->fptr_stego_image == NULL)
    {
    	perror("fopen");
    	fprintf(stderr, "%s: Unable to open file %s\n", __FILE__, encInfo->stego_image_fname);

    	return e_failure;
    }

    // No failure return e_success
    return e_success;
}

OperationType check_operation_type(char *argv[]) {
    char *operation = *(argv + 1);
    if(operation == NULL) {
        return e_unsupported;
    }
    if(operation[0] != '-' || operation[2] != '\0') {
        return e_unsupported;
    }
    
    if(operation[1] == 'e') {
        return e_encode;
    }
    else if(operation[1] == 'd') {
        return e_decode;
    }
    else {
        return e_unsupported;
    }
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

Status read_and_validate_encode_args(char *argv[], EncodeInfo *encInfo) {
    // Source Image
    if(argv[2] == NULL) {
        return e_failure;
    }
    if(filename_bmp_validate(argv[2])) {
        return e_failure;
    }
    encInfo->src_image_fname = argv[2];

    // Secret File
    if(argv[3] == NULL) {
        return e_failure;
    }
    encInfo->secret_fname = argv[3];

    char *letter = encInfo->secret_fname, *word = encInfo->secret_fname;
    for(; *letter != '\0'; letter++);
    for(; *letter != '.' && letter != word; letter--);
    if(letter == word) {
        return e_failure;
    }
    uint extn_len = 0;
    for(; *letter != '\0'; letter++, extn_len++) {
        encInfo->extn_secret_file[extn_len] = *letter;
    }
    encInfo->extn_secret_file[extn_len] = '\0';
    encInfo->size_secret_file_extn = extn_len;
    if(extn_len > MAX_FILE_SUFFIX) {
        return e_failure;
    }

    // Destination Image
    if(argv[4] == NULL) {
        encInfo->stego_image_fname = "veiled_words.bmp";
        return e_success;
    }
    if(filename_bmp_validate(argv[4])) {
        return e_failure;
    }
    encInfo->stego_image_fname = argv[4];

    return e_success;
}

static void cleanup_fp(EncodeInfo *encInfo) {
    if(encInfo->fptr_src_image != NULL) {
        fclose(encInfo->fptr_src_image);
        encInfo->fptr_src_image = NULL;
    }
    if(encInfo->fptr_secret != NULL) {
        fclose(encInfo->fptr_secret);
        encInfo->fptr_secret = NULL;
    }
    if(encInfo->fptr_stego_image != NULL) {
        fclose(encInfo->fptr_stego_image);
        encInfo->fptr_stego_image = NULL;
    }
    fprintf(stdout, "%s: File pointers closed; Resource Leak Averted\n", __FILE__);
}

Status do_encoding(EncodeInfo *encInfo) {
    if(open_files(encInfo) == e_failure) {
        fprintf(stderr, "%s: File open failed\n", __FILE__);
        cleanup_fp(encInfo);
        return e_failure;
    }
    fprintf(stdout, "%s: File opens success\n", __FILE__);
    
    if(check_capacity(encInfo) == e_failure) {
        fprintf(stderr, "%s: File not suitable for encoding.\n", __FILE__);
        cleanup_fp(encInfo);
        return e_failure;
    }
    fprintf(stdout, "%s: File suitable for encoding.\n", __FILE__);

    if(copy_bmp_header(encInfo->fptr_src_image, encInfo->fptr_stego_image) == e_failure) {
        fprintf(stderr, "%s: Failed to copy bmp header.\n", __FILE__);
        cleanup_fp(encInfo);
        return e_failure;
    }
    fprintf(stdout, "%s: BMP header duplication successful.\n", __FILE__);

    if(encode_magic_string(MAGIC_STRING, encInfo) == e_failure) {
        fprintf(stderr, "%s: Failed to encode magic string.\n", __FILE__);
        cleanup_fp(encInfo);
        return e_failure;
    }
    fprintf(stdout, "%s: Magic string encoding successful.\n", __FILE__);

    if(encode_secret_file_extn_size(encInfo->size_secret_file_extn, encInfo) == e_failure) {
        fprintf(stderr, "%s: Failed to encode file extension size.\n", __FILE__);
        cleanup_fp(encInfo);
        return e_failure;
    }
    fprintf(stdout, "%s: File extension size encoding successful.\n", __FILE__);

    if(encode_secret_file_extn(encInfo->extn_secret_file, encInfo) == e_failure) {
        fprintf(stderr, "%s: Failed to encode file extension.\n", __FILE__);
        cleanup_fp(encInfo);
        return e_failure;
    }
    fprintf(stdout, "%s: File extension encoding successful.\n", __FILE__);

    if(encode_secret_file_size(encInfo->size_secret_file, encInfo) == e_failure) {
        fprintf(stderr, "%s: Failed to encode file size.\n", __FILE__);
        cleanup_fp(encInfo);
        return e_failure;
    }
    fprintf(stdout, "%s: File size encoding successful.\n", __FILE__);

    if(encode_secret_file_data(encInfo) == e_failure) {
        fprintf(stderr, "%s: Failed to encode file data.\n", __FILE__);
        cleanup_fp(encInfo);
        return e_failure;
    }
    fprintf(stdout, "%s: File data encoding successful.\n", __FILE__);

    if(copy_remaining_img_data(encInfo->fptr_src_image, encInfo->fptr_stego_image) == e_failure) {
        fprintf(stderr, "%s: Failed to duplicate remainder file data.\n", __FILE__);
        cleanup_fp(encInfo);
        return e_failure;
    }
    fprintf(stdout, "%s: Remainder file data duplication successful.\n", __FILE__);

    cleanup_fp(encInfo);
    return e_success;
}

Status copy_remaining_img_data(FILE *fptr_src, FILE *fptr_dest) {
    char buffer[MAX_FILE_DATA_BUFFER_SIZE];
    size_t bytes_read;
    while((bytes_read = fread(&buffer, 1, MAX_FILE_DATA_BUFFER_SIZE, fptr_src)) > 0) {
        if(fwrite(&buffer, 1, bytes_read, fptr_dest) != bytes_read) {
            return e_failure;
        }
    }
    return e_success;
}

Status encode_secret_file_data(EncodeInfo *encInfo) {
    fseek(encInfo->fptr_secret, 0, SEEK_SET);
    char data_buffer[MAX_FILE_DATA_BUFFER_SIZE];

    size_t bytes_read;
    while((bytes_read = fread(data_buffer, 1, MAX_FILE_DATA_BUFFER_SIZE, encInfo->fptr_secret)) > 0) {

        if(encode_data_to_image(data_buffer, bytes_read, encInfo->fptr_src_image, encInfo->fptr_stego_image) == e_failure) {
            return e_failure;
        }
    }

    return e_success;
}

Status encode_secret_file_size(uint64_t file_size, EncodeInfo *encInfo) {
    size_t size = e_file_size_field*MAX_IMAGE_BUF_SIZE;
    uint8_t buffer[size];
    FILE *fptr_src_image = encInfo->fptr_src_image;
    FILE *fptr_stego_image = encInfo->fptr_stego_image;
    uint8_t *file_size_byte = (uint8_t *)&file_size;

    if(fread(buffer, 1, size, fptr_src_image) != size) {
        return e_failure;
    }
    for(int8_t j = 0; j < e_file_size_field; j++) {
        if(encode_byte_to_lsb(file_size_byte[j], &buffer[(j*MAX_IMAGE_BUF_SIZE)]) == e_failure) {
            return e_failure;
        }
    }
    if(fwrite(buffer, 1, size, fptr_stego_image) != size) {
        return e_failure;
    }
    
    return e_success;
}

Status encode_secret_file_extn(const char *file_extn, EncodeInfo *encInfo) {
    return encode_data_to_image(file_extn, encInfo->size_secret_file_extn, encInfo->fptr_src_image, encInfo->fptr_stego_image);
}

Status encode_secret_file_extn_size(const uint extn_size, EncodeInfo *encInfo) {
    size_t size = e_file_extn_size_field*MAX_IMAGE_BUF_SIZE;
    uint8_t buffer[size];
    FILE *fptr_src_image = encInfo->fptr_src_image;
    FILE *fptr_stego_image = encInfo->fptr_stego_image;
    uint8_t *extn_size_byte = (uint8_t *)&extn_size;

    if(fread(buffer, 1, size, fptr_src_image) != size) {
        return e_failure;
    }
    for(int8_t j = 0; j < e_file_extn_size_field; j++) {
        if(encode_byte_to_lsb(extn_size_byte[j], &buffer[(j*MAX_IMAGE_BUF_SIZE)]) == e_failure) {
            return e_failure;
        }
    }
    if(fwrite(buffer, 1, size, fptr_stego_image) != size) {
        return e_failure;
    }
    
    return e_success;
}

Status encode_magic_string(const char *magic_string, EncodeInfo *encInfo) {
    return encode_data_to_image(magic_string, e_magic_string_field, encInfo->fptr_src_image, encInfo->fptr_stego_image);
}

Status encode_data_to_image(const char *data, size_t size, FILE *fptr_src_image, FILE *fptr_stego_image) {
    uint8_t buffer[MAX_IMAGE_BUF_SIZE];

    for(size_t i = 0; i < size; i++) {
        if(fread(buffer, 1, MAX_IMAGE_BUF_SIZE, fptr_src_image) != MAX_IMAGE_BUF_SIZE) {
            return e_failure;
        }
        if(encode_byte_to_lsb(data[i], buffer) == e_failure) {
            return e_failure;
        }
        if(fwrite(buffer, 1, MAX_IMAGE_BUF_SIZE, fptr_stego_image) != MAX_IMAGE_BUF_SIZE) {
            return e_failure;
        }
    }
    
    return e_success;
}

Status encode_byte_to_lsb(const uint8_t data, uint8_t *image_buffer) {
    uint8_t mask = 0xFE;
    for(uint8_t i = 0; i < MAX_IMAGE_BUF_SIZE; i++) {
        image_buffer[i] = (image_buffer[i] & mask) | ((data>>(7 - i)) & 0x01);
    }
    return e_success;
}

Status copy_bmp_header(FILE *fptr_src_image, FILE *fptr_dest_image) {
    fseek(fptr_src_image, 0, SEEK_SET);
    fseek(fptr_dest_image, 0, SEEK_SET);
    char header[BMP_HEADER_SIZE];

    size_t bytes_transferred = fread(header, 1, BMP_HEADER_SIZE, fptr_src_image);
    if(bytes_transferred != BMP_HEADER_SIZE) {
        return e_failure;
    }

    bytes_transferred = fwrite(header, 1, BMP_HEADER_SIZE, fptr_dest_image);
    if(bytes_transferred != BMP_HEADER_SIZE) {
        return e_failure;
    }

    return e_success;
}

Status check_capacity(EncodeInfo *encInfo) {
    encInfo->image_capacity = get_image_size_for_bmp(encInfo->fptr_src_image);
    encInfo->size_secret_file = get_file_size(encInfo->fptr_secret);

    if(encInfo->image_capacity < ((encInfo->size_secret_file + e_magic_string_field + 
        e_file_extn_size_field + e_file_size_field + encInfo->size_secret_file_extn)*MAX_IMAGE_BUF_SIZE)) {
        return e_failure;
    }
    return e_success;
}

uint64_t get_file_size(FILE *fptr) {
    fseek(fptr, 0, SEEK_END);

    int64_t size = (int64_t)ftell(fptr);
    if(size == -1) {
        fprintf(stderr, "%s: Unable to determine size.\n", __FILE__);
        return 0;
    }

    return (uint64_t)size;
}
