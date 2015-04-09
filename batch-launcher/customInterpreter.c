#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <string.h>

int main( const int argc, const char ** argv )
{
	char *line = NULL;
	size_t lineLength = 0;
	ssize_t read;
	int i=1;
	int returnValue=0;
	FILE * file = NULL;

	if( 1 == argc )
	{
		file=stdin;
	}

	do
	{
		if( i < argc )
		{
			//Open file or read stdin
			if( 0 == strcmp( "-", argv[i] ) )
			{
				file=stdin;
			}
			else
			{
				file=fopen( argv[i], "r" );
				if( NULL == file )
				{
					fprintf( stderr, "Error cannot open file %s for reading: %s\n", argv[i], strerror( errno ) );
					returnValue=1;
					i++;
					continue;
				}	
			}
		}

		errno=0;	
		while( -1 != ( read = getline( &line, &lineLength, file ) ) ) {
			printf( "%s", line );
		}

		if( 0 != errno )
		{
			fprintf( stderr, "Error during file %s reading: %s\n", argv[i], strerror( errno ) );
			returnValue=1;
		}

		if( file != stdin )
		{
			if( 0 != fclose( file ) )
			{
				fprintf( stderr, "Error closing file %s: %s\n", argv[i], strerror( errno ) );
				returnValue=1;

			}
		}

		i++;
	}
	while( i < argc );

	free( line );
	return returnValue;
}

