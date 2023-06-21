/*
  Warnings:

  - You are about to drop the column `crateAt` on the `Like` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `Like` table. All the data in the column will be lost.
  - You are about to drop the column `crateAt` on the `Colecao` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `Colecao` table. All the data in the column will be lost.
  - You are about to drop the column `crateAt` on the `Conteudo` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `Conteudo` table. All the data in the column will be lost.
  - You are about to drop the column `crateAt` on the `Login` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `Login` table. All the data in the column will be lost.
  - You are about to drop the column `crateAt` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `User` table. All the data in the column will be lost.
  - You are about to drop the column `crateAt` on the `Comentario` table. All the data in the column will be lost.
  - You are about to drop the column `updateAt` on the `Comentario` table. All the data in the column will be lost.
  - Added the required column `updatedAt` to the `Like` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Colecao` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Conteudo` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Login` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `User` table without a default value. This is not possible if the table is not empty.
  - Added the required column `updatedAt` to the `Comentario` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Like" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "authorId" INTEGER NOT NULL,
    "contentId" INTEGER NOT NULL,
    "cratedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Like_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Like_contentId_fkey" FOREIGN KEY ("contentId") REFERENCES "Conteudo" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Like" ("authorId", "contentId", "id") SELECT "authorId", "contentId", "id" FROM "Like";
DROP TABLE "Like";
ALTER TABLE "new_Like" RENAME TO "Like";
CREATE TABLE "new_Colecao" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT NOT NULL,
    "conteudos" INTEGER NOT NULL,
    "cratedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Colecao_conteudos_fkey" FOREIGN KEY ("conteudos") REFERENCES "Conteudo" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Colecao" ("conteudos", "id", "titulo") SELECT "conteudos", "id", "titulo" FROM "Colecao";
DROP TABLE "Colecao";
ALTER TABLE "new_Colecao" RENAME TO "Colecao";
CREATE TABLE "new_Conteudo" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT NOT NULL,
    "path" TEXT NOT NULL,
    "coverpath" TEXT,
    "authorId" INTEGER NOT NULL,
    "cratedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Conteudo_authorId_fkey" FOREIGN KEY ("authorId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Conteudo" ("authorId", "coverpath", "id", "path", "titulo") SELECT "authorId", "coverpath", "id", "path", "titulo" FROM "Conteudo";
DROP TABLE "Conteudo";
ALTER TABLE "new_Conteudo" RENAME TO "Conteudo";
CREATE TABLE "new_Login" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "email" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    "cratedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Login_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Login" ("email", "id", "password", "role", "userId", "username") SELECT "email", "id", "password", "role", "userId", "username" FROM "Login";
DROP TABLE "Login";
ALTER TABLE "new_Login" RENAME TO "Login";
CREATE UNIQUE INDEX "Login_email_key" ON "Login"("email");
CREATE UNIQUE INDEX "Login_username_key" ON "Login"("username");
CREATE UNIQUE INDEX "Login_userId_key" ON "Login"("userId");
CREATE TABLE "new_User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "lastname" TEXT NOT NULL,
    "date" TEXT,
    "cratedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL
);
INSERT INTO "new_User" ("date", "id", "lastname", "name") SELECT "date", "id", "lastname", "name" FROM "User";
DROP TABLE "User";
ALTER TABLE "new_User" RENAME TO "User";
CREATE TABLE "new_Comentario" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "texto" TEXT NOT NULL,
    "authorID" INTEGER NOT NULL,
    "contentId" INTEGER NOT NULL,
    "cratedAt" DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    "updatedAt" DATETIME NOT NULL,
    CONSTRAINT "Comentario_authorID_fkey" FOREIGN KEY ("authorID") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Comentario_contentId_fkey" FOREIGN KEY ("contentId") REFERENCES "Conteudo" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Comentario" ("authorID", "contentId", "id", "texto") SELECT "authorID", "contentId", "id", "texto" FROM "Comentario";
DROP TABLE "Comentario";
ALTER TABLE "new_Comentario" RENAME TO "Comentario";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
