/*
  Warnings:

  - You are about to drop the `Clip` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Marker` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Metadata` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `Space` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `_ClipToSpace` table. If the table is not empty, all the data it contains will be lost.
  - The primary key for the `File` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `runTime` on the `File` table. All the data in the column will be lost.
  - You are about to drop the column `size` on the `File` table. All the data in the column will be lost.
  - You are about to drop the column `type` on the `File` table. All the data in the column will be lost.
  - You are about to alter the column `id` on the `File` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - The primary key for the `Tag` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `name` on the `Tag` table. All the data in the column will be lost.
  - You are about to drop the column `segmentId` on the `Tag` table. All the data in the column will be lost.
  - You are about to drop the column `spaceId` on the `Tag` table. All the data in the column will be lost.
  - You are about to alter the column `id` on the `Tag` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - The primary key for the `Segment` table will be changed. If it partially fails, the table could be left without primary key constraint.
  - You are about to drop the column `clipId` on the `Segment` table. All the data in the column will be lost.
  - You are about to drop the column `preferences` on the `Segment` table. All the data in the column will be lost.
  - You are about to drop the column `tsBegin` on the `Segment` table. All the data in the column will be lost.
  - You are about to drop the column `tsEnd` on the `Segment` table. All the data in the column will be lost.
  - You are about to alter the column `id` on the `Segment` table. The data in that column could be lost. The data in that column will be cast from `String` to `Int`.
  - Added the required column `format` to the `File` table without a default value. This is not possible if the table is not empty.
  - Added the required column `key` to the `Tag` table without a default value. This is not possible if the table is not empty.
  - Added the required column `value` to the `Tag` table without a default value. This is not possible if the table is not empty.
  - Added the required column `begin` to the `Segment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `end` to the `Segment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `sourceId` to the `Segment` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Segment` table without a default value. This is not possible if the table is not empty.

*/
-- DropIndex
DROP INDEX "Clip_fileId_key";

-- DropIndex
DROP INDEX "_ClipToSpace_B_index";

-- DropIndex
DROP INDEX "_ClipToSpace_AB_unique";

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Clip";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Marker";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Metadata";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "Space";
PRAGMA foreign_keys=on;

-- DropTable
PRAGMA foreign_keys=off;
DROP TABLE "_ClipToSpace";
PRAGMA foreign_keys=on;

-- CreateTable
CREATE TABLE "Video" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "TagType" (
    "key" TEXT NOT NULL PRIMARY KEY,
    "name" TEXT NOT NULL,
    "description" TEXT NOT NULL,
    "format" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);

-- CreateTable
CREATE TABLE "_TagToVideo" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_TagToVideo_A_fkey" FOREIGN KEY ("A") REFERENCES "Tag" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_TagToVideo_B_fkey" FOREIGN KEY ("B") REFERENCES "Video" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_File" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "location" TEXT NOT NULL,
    "format" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);
INSERT INTO "new_File" ("createdAt", "id", "location", "name", "updatedAt") SELECT "createdAt", "id", "location", "name", "updatedAt" FROM "File";
DROP TABLE "File";
ALTER TABLE "new_File" RENAME TO "File";
CREATE TABLE "new_Tag" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "key" TEXT NOT NULL,
    "value" TEXT NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Tag_key_fkey" FOREIGN KEY ("key") REFERENCES "TagType" ("key") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Tag" ("createdAt", "id", "updatedAt") SELECT "createdAt", "id", "updatedAt" FROM "Tag";
DROP TABLE "Tag";
ALTER TABLE "new_Tag" RENAME TO "Tag";
CREATE TABLE "new_Segment" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "sourceId" INTEGER NOT NULL,
    "begin" REAL NOT NULL,
    "end" REAL NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    "tagId" INTEGER,
    CONSTRAINT "Segment_sourceId_fkey" FOREIGN KEY ("sourceId") REFERENCES "Video" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Segment_tagId_fkey" FOREIGN KEY ("tagId") REFERENCES "Tag" ("id") ON DELETE SET NULL ON UPDATE CASCADE
);
INSERT INTO "new_Segment" ("id") SELECT "id" FROM "Segment";
DROP TABLE "Segment";
ALTER TABLE "new_Segment" RENAME TO "Segment";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "TagType_key_key" ON "TagType"("key");

-- CreateIndex
CREATE UNIQUE INDEX "_TagToVideo_AB_unique" ON "_TagToVideo"("A", "B");

-- CreateIndex
CREATE INDEX "_TagToVideo_B_index" ON "_TagToVideo"("B");
