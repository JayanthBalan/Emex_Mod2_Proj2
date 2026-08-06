
#include <stdio.h>
#include "encode.h"
#include "decode.h"
#include "types.h"

uint8_t encodeOperation(char *argv[]);
uint8_t decodeOperation(char *argv[]);

int main(int argc, char *argv[])
{
    if(argc <= 1) {
        fprintf(stdout, "%s: Invalid Command Line Argument", __FILE__);
        return -1;
    }

    OperationType op_type = check_operation_type(argv);
    if(op_type == e_encode) {
        fprintf(stdout, "%s: Operation type is Encode\n", __FILE__);
        return encodeOperation(argv);
    }
    else if(op_type == e_decode) {
        fprintf(stdout, "%s: Operation type is Decode\n", __FILE__);
        return decodeOperation(argv);
    }
    else {
        fprintf(stderr, "%s: Operation type is Unsupported\nInvalid Command Line Argument\n", __FILE__);
        fprintf(stderr, "%s: Encode Command Syntax: ./a.out -e beautiful.bmp secret [stego_img.bmp]\n", __FILE__);
        fprintf(stderr, "%s: Decode Command Syntax: ./a.out -d stego_img.bmp [output_secret_file]\n", __FILE__);
    }

    return 0;
}

uint8_t decodeOperation(char *argv[]) {
    DecodeInfo decInfo = {0};

    Status stat = read_and_validate_decode_args(argv, &decInfo);
    if(stat == e_failure) {
        fprintf(stderr, "%s: Decode arguments invalid\n", __FILE__);
        return -1;
    }
    fprintf(stdout, "%s: Decode arguments valid\n", __FILE__);

    Status do_dec_stat = do_decoding(&decInfo);
    if(do_dec_stat == e_failure) {
        fprintf(stderr, "%s: Decoding failed\n", __FILE__);
        return -1;
    }
    fprintf(stdout, "%s: Decoding successful\n", __FILE__);

    return 0;
}

uint8_t encodeOperation(char *argv[]) {
    EncodeInfo encInfo = {0};
    Status stat = read_and_validate_encode_args(argv, &encInfo);
    if(stat == e_failure) {
        fprintf(stderr, "%s: Encode arguments invalid\n", __FILE__);
        return -1;
    }
    fprintf(stdout, "%s: Encode arguments valid\n", __FILE__);

    Status do_enc_stat = do_encoding(&encInfo);
    if(do_enc_stat == e_failure) {
        fprintf(stderr, "%s: Encoding failed\n", __FILE__);
        return -1;
    }
    fprintf(stdout, "%s: Encoding successful\n", __FILE__);

    return 0;
}
