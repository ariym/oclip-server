/*
  Warnings:

  - You are about to drop the column `tagId` on the `Segment` table. All the data in the column will be lost.
  - Added the required column `sourceId` to the `Video` table without a default value. This is not possible if the table is not empty.

*/
-- CreateTable
CREATE TABLE "_SegmentToTag" (
    "A" INTEGER NOT NULL,
    "B" INTEGER NOT NULL,
    CONSTRAINT "_SegmentToTag_A_fkey" FOREIGN KEY ("A") REFERENCES "Segment" ("id") ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT "_SegmentToTag_B_fkey" FOREIGN KEY ("B") REFERENCES "Tag" ("id") ON DELETE CASCADE ON UPDATE CASCADE
);

-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Segment" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "sourceId" INTEGER NOT NULL,
    "begin" REAL NOT NULL,
    "end" REAL NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Segment_sourceId_fkey" FOREIGN KEY ("sourceId") REFERENCES "Video" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Segment" ("begin", "createdAt", "end", "id", "sourceId", "updatedAt") SELECT "begin", "createdAt", "end", "id", "sourceId", "updatedAt" FROM "Segment";
DROP TABLE "Segment";
ALTER TABLE "new_Segment" RENAME TO "Segment";
CREATE TABLE "new_Video" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "sourceId" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Video_sourceId_fkey" FOREIGN KEY ("sourceId") REFERENCES "File" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Video" ("createdAt", "id", "name", "updatedAt") SELECT "createdAt", "id", "name", "updatedAt" FROM "Video";
DROP TABLE "Video";
ALTER TABLE "new_Video" RENAME TO "Video";
CREATE UNIQUE INDEX "Video_sourceId_key" ON "Video"("sourceId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;

-- CreateIndex
CREATE UNIQUE INDEX "_SegmentToTag_AB_unique" ON "_SegmentToTag"("A", "B");

-- CreateIndex
CREATE INDEX "_SegmentToTag_B_index" ON "_SegmentToTag"("B");
