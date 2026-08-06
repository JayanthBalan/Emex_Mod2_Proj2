#include <stdio.h>
#include "encode.h"
#include "types.h"

uint8_t encodeOperation(char *argv[]);

int main(int argc, char *argv[])
{
    OperationType op_type = check_operation_type(argv);
    if(op_type == e_encode) {
        fprintf(stdout, "%s: Operation type is Encode\n", __FILE__);
        return encodeOperation(argv);
    }
    else if(op_type == e_decode) {
        fprintf(stdout, "%s: Operation type is Decode\n");
        return decodeOperation(argv);
    }
    else {
        fprintf(stderr, "%s: Operation type is Unsupported\nInvalid Command Line Argument\n");
        fprintf(stderr, "%s: Encode Command Syntax: ./a.out -e beautiful.bmp secret [stego_img.bmp]\n");
        fprintf(stderr, "%s: Decode Command Syntax: ./a.out -d stego_img.bmp [output_secret_file]\n");
    }

    return 0;
}

uint8_t encodeOperation(char *argv[]) {
    EncodeInfo encInfo;
    Status stat = read_and_validate_encode_args(argv, &encInfo);
    if(stat == e_failure) {
        fprintf(stderr, "%s: Encode arguments invalid\n");
        return -1;
    }
    fprintf(stdout, "%s: Encode arguments valid\n");

    Status do_enc_stat = do_encoding(&encInfo);
    if(do_enc_stat == e_failure) {
        fprintf(stderr, "%s: Encoding failed\n");
        return -1;
    }
    fprintf(stdout, "%s: Encoding successful\n");

    return 0;
}
