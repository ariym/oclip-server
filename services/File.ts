/*
  _____ _ _        ____                                  
 |  ___(_) | ___  | __ ) _ __ _____      _____  ___ _ __ 
 | |_  | | |/ _ \ |  _ \| '__/ _ \ \ /\ / / __|/ _ \ '__|
 |  _| | | |  __/ | |_) | | | (_) \ V  V /\__ \  __/ |   
 |_|   |_|_|\___| |____/|_|  \___/ \_/\_/ |___/\___|_|   
                                                         
create tables (1. files, 2. jobs, 3. tags)
jobs table (every time a job is commisioned store it there)
add logic to new file adding routine if(!file_in_jobs_whisper) add file.whisperx to jobs queue. // if no history of file having had whisperx run on it, run it
*/

import { readdir,readFile } from 'node:fs/promises';

export type Directory = {
  path: string
  contents: Object[]
}

export default class Browser {
  path: string;

  constructor(startPath:string){
    this.path = startPath;
  }

  async readDir(path:string = this.path) {
    const contents = await readdir(path); // returns array of strings
    return { path, contents };
  }

  async openFile(path:string = this.path){
    const contents = await readFile(path, { encoding: 'utf8' });
    return contents;
  }
}