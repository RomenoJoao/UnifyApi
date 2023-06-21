/*
  Warnings:

  - Added the required column `username` to the `Login` table without a default value. This is not possible if the table is not empty.

*/
-- RedefineTables
PRAGMA foreign_keys=OFF;
CREATE TABLE "new_Login" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "email" TEXT NOT NULL,
    "username" TEXT NOT NULL,
    "password" TEXT NOT NULL,
    "role" TEXT NOT NULL,
    "userId" INTEGER NOT NULL,
    CONSTRAINT "Login_userId_fkey" FOREIGN KEY ("userId") REFERENCES "User" ("id") ON DELETE RESTRICT ON UPDATE CASCADE
);
INSERT INTO "new_Login" ("email", "id", "password", "role", "userId") SELECT "email", "id", "password", "role", "userId" FROM "Login";
DROP TABLE "Login";
ALTER TABLE "new_Login" RENAME TO "Login";
CREATE UNIQUE INDEX "Login_email_key" ON "Login"("email");
CREATE UNIQUE INDEX "Login_username_key" ON "Login"("username");
CREATE UNIQUE INDEX "Login_userId_key" ON "Login"("userId");
PRAGMA foreign_key_check;
PRAGMA foreign_keys=ON;
