import { PrismaClient } from '@prisma/client';
const prisma = new PrismaClient();

export interface submitTagParams {
  key: string;
  value: string;
}

// this must always return an array
export const submitTags = async (tags: submitTagParams[]) => {

  if (tags.length === 1) {
    const { key, value } = tags[0];
    // save single tag
    const newTag = await prisma.tag.create({
      data: {
        key,
        value
      }
    });

    return [newTag];
  } else if (tags.length > 1) {

    // todo: prisma createMany is not supported by SQLite
    // const newTags = await prisma.tag.createMany({
    //   data: tags.map(tag => {
    //   })
    // })

    // workaround for SQLite (no prisma createMany)
    const newTags = await Promise.all(tags.map(async (tag) => {
      const { key, value } = tag;
      // save single tag
      const newTag = await prisma.tag.create({
        data: {
          key,
          value
        }
      });
      return newTag
    }));

    return newTags;
  } else {
    throw "No tags provided."
  }
}