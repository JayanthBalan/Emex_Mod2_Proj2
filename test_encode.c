#include <stdio.h>
#include "encode.h"
#include "types.h"

int main(int argc, char *argv[])
{
    OperationType op_type = check_operation_type(argv);
    if(op_type == e_encode) {
        printf("Info: Operation type is Encode\n");
    }
    else if(op_type == e_decode) {
        printf("Info: Operation type is Decode\n");
    }
    else {
        printf("Info: Operation type is Unsupported\nInvalid Command Line Argument\n");
        printf("Encode Command Syntax: ./a.out -e beautiful.bmp secret.txt [stego_img.bmp]\n");
        printf("Decode Command Syntax: ./a.out -d stego_img.bmp [output_secret_file]\n");
    }

    EncodeInfo encInfo;
    uint img_size;

    // Fill with sample filenames
    encInfo.src_image_fname = "beautiful.bmp";
    encInfo.secret_fname = "secret.txt";
    encInfo.stego_image_fname = "stego_img.bmp";

    // Test open_files
    if (open_files(&encInfo) == e_failure)
    {
    	printf("ERROR: %s function failed\n", "open_files" );
    	return 1;
    }
    else
    {
    	printf("SUCCESS: %s function completed\n", "open_files" );
    }

    // Test get_image_size_for_bmp
    img_size = get_image_size_for_bmp(encInfo.fptr_src_image);
    printf("INFO: Image size = %u\n", img_size);

    return 0;
}
