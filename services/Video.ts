import TFile from '../types/File'
import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

/*
========================================
SUBMITTING A VIDEO
========================================
insert file
insert video(sourceId: file.id)
========================================
*/

export const submitNewVideoFile = async (video: TFile) => {
  // 1. insert into new file table
  const file: { id: number, name: string } = await prisma.file.create({ data: video });

  // 2. insert fileId into video's table
  const savedVideo = await prisma.video.create({
    data: {
      sourceId: file.id,
      name: file.name,
      tags: {
        create: [
          // todo: implement function that spits out key value like t.author("robert ford")
          { key: "upload_date", value: new Date().toISOString() },
          { key: "author", value: "robert ford" },
        ]
      }
    }
  });

  return savedVideo;
}