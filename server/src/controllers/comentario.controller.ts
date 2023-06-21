import { Request, Response } from "express";
import { PrismaClient } from "@prisma/client";
import { ParserService } from "../utils/ParserService";
import { request } from "http";

const prisma = new PrismaClient();
class ComentarioController {
  async getAll(req: Request, res: Response) {
    try {
      const { contentId } = req.body;
      const coments = await prisma.comentario.aggregate({
        where: {
          contentId: {
            equals: contentId,
          },
        },
        _count: true,
      });

      return res.status(200).json(coments);
    } catch (error: any) {
      console.log(error);
      return res.status(500).json({ message: error.message });
    }
  }
  async create(req: Request, res: Response) {
    try {
        const authorId = ParserService(
            req.headers.Authorization || req.cookies.tokens
        ).user_id
        const {contentId} = req.body
        
        const comented = await prisma.comentario.create({
          data: {
            texto: "",
            authorC: {
              connect: {
                id: Number(authorId),
              },
            },
            content: {
              connect: {
                id: contentId,
              },
            },
          },
        });
    } catch (error: any) {
      return res.status(500).json({ message: error.message });
    }
  }
}
