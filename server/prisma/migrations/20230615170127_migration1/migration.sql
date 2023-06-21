-- CreateTable
CREATE TABLE "User" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "email" TEXT NOT NULL,
    "name" TEXT,
    "data" DATETIME NOT NULL,
    "tipo" INTEGER NOT NULL,
    "senha" TEXT
);

-- CreateTable
CREATE TABLE "Comentario" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "texto" TEXT NOT NULL,
    "authorID" INTEGER NOT NULL,
    "comentsVideo" INTEGER NOT NULL,
    CONSTRAINT "Comentario_authorID_fkey" FOREIGN KEY ("authorID") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Comentario_comentsVideo_fkey" FOREIGN KEY ("comentsVideo") REFERENCES "Conteudo" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Like" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "texto" TEXT NOT NULL,
    "authorLike" INTEGER NOT NULL,
    "likesV" INTEGER NOT NULL,
    CONSTRAINT "Like_authorLike_fkey" FOREIGN KEY ("authorLike") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT "Like_likesV_fkey" FOREIGN KEY ("likesV") REFERENCES "Conteudo" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateTable
CREATE TABLE "Conteudo" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT NOT NULL,
    "data" DATETIME NOT NULL,
    "local" TEXT NOT NULL,
    "localcapa" TEXT NOT NULL
);

-- CreateTable
CREATE TABLE "Colecao" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "titulo" TEXT NOT NULL,
    "conteudos" INTEGER NOT NULL,
    CONSTRAINT "Colecao_conteudos_fkey" FOREIGN KEY ("conteudos") REFERENCES "Conteudo" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);

-- CreateIndex
CREATE UNIQUE INDEX "User_email_key" ON "User"("email");
