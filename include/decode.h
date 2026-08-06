
#ifndef DECODE_H
#define DECODE_H

#include "types.h"
#include <stdio.h>
#include <stdint.h>
#include <string.h>
#include <stddef.h>

#define FILE_READ_BLOCK_SIZE 8
#define IMAGE_BYTE_PER_DATA_BYTE 8
#define MAX_FNAME_SIZE 64

typedef struct _DecodeInfo
{
    /* Secret File Info */
    char secret_fname[MAX_FNAME_SIZE];
    FILE *fptr_secret;
    uint64_t size_secret_file;
    uint size_secret_file_extn;

    /* Stego Image Info */
    char *stego_image_fname;
    FILE *fptr_stego_image;

} DecodeInfo;

Status read_and_validate_decode_args(char *argv[], DecodeInfo *encInfo);
Status do_decoding(DecodeInfo *decInfo);
Status validate_magic_string(const char *magic_string, DecodeInfo *decInfo);
Status decode_secret_file_extn_size(uint *file_extn_size, DecodeInfo *decInfo);
Status decode_image_to_data(size_t target_readBytes, FILE *fptr_stego_image, uint8_t *decryptedData);
Status decode_lsb_to_byte(uint8_t enc_data[], uint8_t *destByte);
Status decode_secret_file_extn(uint8_t *extn, DecodeInfo *decInfo);
Status decode_secret_file_size(uint64_t *size_data, DecodeInfo *decInfo);
Status file_extn_correction(char *crct_extn, DecodeInfo *decInfo);
Status decode_secret_file(DecodeInfo *decInfo);

#endif
