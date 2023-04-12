/*
INPUT: video location
OUTPUT: JSON of diarized transcript (for inserting as tags and attaching to video)

create standardized format for
a) file path input (future: remote streaming)
b) json -> tags output
c) progress updates

use: shelljs + whisperx

*/

import shell from 'shelljs'

