import { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";
import { ParserService } from "../utils/ParserService";

const prisma = new PrismaClient();

class ContentClass {
  async create(req: Request, res: Response) {
    try {
      const { titulo, path, coverpath } = req.body;
      const user_id  = ParserService(req.cookies.tokens).user_id;

      const content = await prisma.conteudo.create({
        data: {
          coverpath,
          path,
          titulo,
          author: {
            connect: {
              id: Number(user_id),
            },
          },
        },
      });

      return res.status(201).json(content);
    } catch (error: any) {
      console.log(error);
      return res.status(500).json({ message: error.message });
    }
  }

  async getAll(req: Request, res: Response) {
    try {
      const content = await prisma.conteudo.findMany();
      return res.status(200).json(content);
    } catch (error: any) {
      console.log(error);
      return res.status(500).json({ message: error.message });
    }
  }
}

export default ContentClass;
