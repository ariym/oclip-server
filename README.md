# oClip Media Server

[Original Media Library REST API for using the oClip format.](oclip.org)

## Getting Started

1. Install dependencies ```npm i```

2. Migrate database ```npx prisma migrate dev```

3. Run ```npm run dev```

## How content is handled

1. All added content creates a new row in the Source table.
2. Every source created automatically subsequently creates a new row in the Video table.
3. Extensions can now process the video and return data generated in the form of segments ```{start,end,tags}```

## Project folder structure

- /extensions: (implementation for ffmpeg, ml tools [reuse python wrapper], scheduler, child_process)
- /middleware: universal route needs (e.g. auth, error, response, req/res logging)
- /prisma: database
- /routes: (express trees for: clip, spacetag, programs, find, tag)
- /util: single purpose and reusable

## Useful Commands

### Prisma

```plaintext
# fix issues in prisma.schema
npx prisma format

# update database using migration files
npx prisma migrate dev

# prisma viewer (database editor gui)
npx prisma studio
```
