/*
  Warnings:

  - You are about to drop the column `authorConteudo` on the `Conteudo` table. All the data in the column will be lost.
  - You are about to drop the column `data` on the `Conteudo` table. All the data in the column will be lost.
  - You are about to drop the column `authorLike` on the `Like` table. All the data in the column will be lost.
  - You are about to drop the column `likesV` on the `Like` table. All the data in the column will be lost.
  - You are about to drop the column `texto` on the `Like` table. All the data in the column will be lost.
  - You are about to drop the column `comentsVideo` on the `Comentario` table. All the data in the column will be lost.
  - You are about to drop the column `senha` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `tipo` on the `User` table. All the data in the column will be lost.
  - Added the required column `authorId` to the `Conteudo` table without a default value. This is not possible if the table is not empty.
  - Added the required column `authorId` to the `Like` table without a default value. This is not possible if the table is not empty.
  - Added the required column `contentId` to the `Like` table without a default value. This is not possible if the table is not empty.
  - Added the required column `contentId` to the `Comentario` table without a default value. This is not possible if the table is not empty.
  - Added the required column `password` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `role` to the `User` table without a default value. This is not possible if the table is not empty.
  - Made the column `name` on table `User` required. This step will fail if there are existing NULL values in that column.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Conteudo" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT NOT NULL,
    "local" TEXT NOT NULL,
    "localcapa" TEXT NOT NULL,
    "authorId" INTEGER NOT NULL,
    "createdAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT "Conteudo_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Conteudo" ("id", "local", "localcapa", "titulo") SELECT "id", "local", "localcapa", "titulo" FROM "Conteudo";
DROP TABLE "Conteudo";
ALTER TABLE "new_Conteudo" RENAME TO "Conteudo";
CREATE TABLE "new_Like" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "authorId" INTEGER NOT NULL,
    "contentId" INTEGER NOT NULL,
    CONSTRAINT "Like_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Like_contentId_fkey" FOREIGN KEY ("contentId") REFERENCES "Conteudo" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Like" ("id") SELECT "id" FROM "Like";
DROP TABLE "Like";
ALTER TABLE "new_Like" RENAME TO "Like";
CREATE TABLE "new_Comentario" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "texto" TEXT NOT NULL,
    "authorID" INTEGER NOT NULL,
    "contentId" INTEGER NOT NULL,
    CONSTRAINT "Comentario_authorID_fkey" FOREIGN KEY ("authorID") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Comentario_contentId_fkey" FOREIGN KEY ("contentId") REFERENCES "Conteudo" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Comentario" ("authorID", "id", "texto") SELECT "authorID", "id", "texto" FROM "Comentario";
DROP TABLE "Comentario";
ALTER TABLE "new_Comentario" RENAME TO "Comentario";
CREATE TABLE "new_User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "email" TEXT NOT NULL,
    "name" TEXT NOT NULL,
    "data" DATETIME NOT NULL,
    "role" TEXT NOT NULL,
    "password" TEXT NOT NULL
);
INSERT INTO "new_User" ("data", "email", "id", "name") SELECT "data", "email", "id", "name" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
