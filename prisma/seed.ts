import { PrismaClient } from '@prisma/client'
const prisma = new PrismaClient()
async function main() {

  // todo: add more default tagtypes
  // document full list in readme


  const uploadDate = await prisma.tagType.create({
    data: {
      key: "upload_date",
      name: "Upload Date",
      description: "Date video was uploaded to oClip.",
      format: "string",
    },
  })

  const authorType = await prisma.tagType.create({
    data: {
      key: "author",
      name: "Author",
      description: "The author of the video",
      format: "string",
    },
  })

  console.log("seeded types", authorType, uploadDate)
}



main()
  .then(async () => {
    await prisma.$disconnect()
  })
  .catch(async (e) => {
    console.error(e)
    await prisma.$disconnect()
    process.exit(1)
  })