/*
  Warnings:

  - You are about to drop the column `local` on the `Conteudo` table. All the data in the column will be lost.
  - You are about to drop the column `localcapa` on the `Conteudo` table. All the data in the column will be lost.
  - Added the required column `coverpath` to the `Conteudo` table without a default value. This is not possible if the table is not empty.
  - Added the required column `path` to the `Conteudo` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Conteudo" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT NOT NULL,
    "path" TEXT NOT NULL,
    "coverpath" TEXT NOT NULL,
    "authorId" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Conteudo_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Conteudo" ("authorId", "createdAt", "id", "titulo") SELECT "authorId", "createdAt", "id", "titulo" FROM "Conteudo";
DROP TABLE "Conteudo";
ALTER TABLE "new_Conteudo" RENAME TO "Conteudo";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
