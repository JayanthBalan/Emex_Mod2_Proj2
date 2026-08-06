#ifndef TYPES_H
#define TYPES_H

#include <stdint.h>

#define MAGIC_STRING "#*"
#define BMP_HEADER_SIZE 54

/* User defined types */
typedef unsigned long uint;

/* Status will be used in fn. return type */
typedef enum
{
    e_success,
    e_failure
} Status;

typedef enum
{
    e_encode,
    e_decode,
    e_unsupported
} OperationType;

#endif
