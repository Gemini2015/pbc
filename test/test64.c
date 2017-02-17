#include "pbc.h"

#include <stdlib.h>
#include <stdio.h>
#include <stdint.h>
#include <stddef.h>

#include "readfile.h"

static void
dump(uint8_t *buffer, int sz) {
	int i , j;
	for (i=0;i<sz;i++) {
		printf("%02X ",buffer[i]);
		if (i % 16 == 15) {
			for (j = 0 ;j <16 ;j++) {
				char c = buffer[i/16 * 16+j];
				if (c>=32 && c<127) {
					printf("%c",c);
				} else {
					printf(".");
				}
			}
			printf("\n");
		}
	}

	printf("\n");
}

static struct pbc_wmessage *
test_wmessage(struct pbc_env * env)
{
	struct pbc_wmessage * msg = pbc_wmessage_new(env, "Person");

	int64_t v64 = 0x1fffffffffffffff;

	pbc_wmessage_integer(msg, "id", (uint32_t)v64 , (uint32_t)(v64>>32));

	return msg;
}

int
main()
{
	struct pbc_slice slice;
	read_file("test64.pb", &slice);
	if (slice.buffer == NULL)
		return 1;
	struct pbc_env * env = pbc_new();
	int r = pbc_register(env, &slice);
	if (r) {
		printf("Error : %s", pbc_error(env));
		return 1;
	}

	free(slice.buffer);

	struct pbc_wmessage *msg = test_wmessage(env);

	pbc_wmessage_buffer(msg, &slice);

	dump(slice.buffer, slice.len);

	pbc_wmessage_delete(msg);
	pbc_delete(env);

	return 0;
}
