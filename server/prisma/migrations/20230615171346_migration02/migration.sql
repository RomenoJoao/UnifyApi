/*
  Warnings:

  - Added the required column `authorConteudo` to the `Conteudo` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Conteudo" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT NOT NULL,
    "data" DATETIME NOT NULL,
    "local" TEXT NOT NULL,
    "localcapa" TEXT NOT NULL,
    "authorConteudo" INTEGER NOT NULL,
    CONSTRAINT "Conteudo_authorConteudo_fkey" FOREIGN KEY ("authorConteudo") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Conteudo" ("data", "id", "local", "localcapa", "titulo") SELECT "data", "id", "local", "localcapa", "titulo" FROM "Conteudo";
DROP TABLE "Conteudo";
ALTER TABLE "new_Conteudo" RENAME TO "Conteudo";
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
