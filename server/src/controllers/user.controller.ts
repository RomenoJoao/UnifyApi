import { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";
import { UserSchema } from "../validators/user";
import bcrypt from "bcryptjs";

const prisma = new PrismaClient();

class UserController {
  async getAll(req: Request, res: Response) {
    try {
      const users = await prisma.user.findMany({
        include: {
          login: {
            select: {
              email: true,
              role: true,
              username: true,
            },
          },
        },
      });
      if (users.length > 0) {
        return res.status(200).json(users);
      }
      return res.status(204).json(users);
    } catch (error: any) {
      console.log(error);
      return res.status(500).json({ message: error.message });
    }
  }

  async create(req: Request, res: Response) {
    try {
      const request = UserSchema.parse(req.body);

      const data = {
        name: request.name,
        lastname: request.lastname,
        date: request.date,
        login: {
          create: {
            username: request.login.username || "",
            email: request.login.email,
            password: await bcrypt.hash(request.login.password, 10),
            role: request.login.role || "USER",
          },
        },
      };

      const newUser = await prisma.user.create({
        data,
      });

      return res.status(201).json(newUser);
    } catch (error: any) {
      console.log(error);
      return res.status(500).json({ message: error.message });
    }
  }
}

export default UserController;
