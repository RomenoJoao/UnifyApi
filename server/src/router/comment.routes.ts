import { Router } from "express";
import ComentarioController from "../controllers/comentario.controller";

const router = Router();
const comentarioController = new ComentarioController();

router.post("/", comentarioController.create);
router.get("/", comentarioController.getAll);
router.get("/count", comentarioController.count);
router.delete("/:comentarioid", comentarioController.delete);

export default router;
