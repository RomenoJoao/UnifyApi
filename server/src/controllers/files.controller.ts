import { Response, Request } from "express";
import fs from "fs";
import { resolve } from "path";
import mime from "mime-types";

interface IFile {
  originalName: string;
  filename: string;
}

class FileController {
  async uploadFiles(req: Request, res: Response) {
    var filePath = [] as IFile[];
    for (const file of req.files as Express.Multer.File[]) {
      filePath.push({
        originalName: file.originalname,
        filename: file.filename,
      });
    }

    if (filePath.length === 0) {
      return res.status(400).json({ message: "Nenhum ficheiro enviado" });
    }

    return res
      .status(200)
      .json({ filePath, message: "Upload realizado com sucesso" });
  }
  async getFile(req: Request, res: Response) {
    const { filename } = req.params;

    const path = resolve(__dirname, "..", "..", "uploads", filename);

    try {
      if (!fs.existsSync(path)) {
        return res.status(400).json({ message: "Ficheiro não encontrado" });
      }

      const mimeType = mime.lookup(path) as string;

      return res.type(mimeType).sendFile(path);
    } catch (error) {
      console.log(error);
      return res.status(400).json({ message: "Ficheiro não encontrado" });
    }
  }
}

export default FileController;
