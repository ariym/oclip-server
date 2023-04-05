import FileType from '../types/File'

import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

export const submitVideo = async (video: FileType) => {

  // 1. save as new file
  const file: { id: number, name: string } = await prisma.file.create({ data: video });

  // 2. save source file with tags as new video entry
  const savedVideo = await prisma.video.create({
    data: {
      sourceId: file.id, name: file.name,
      tags: {
        create: [
          { key: "upload_date", value: new Date().toISOString() },
          { key: "author", value: "robert ford" },
        ]
      }
    }
  });

  return savedVideo;
}