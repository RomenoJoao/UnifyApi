import Router, { Request, Response } from "express";
import UserController from "../controllers/user.controller";

const router = Router();

const userController = new UserController();

router.get("/", userController.getAll);
router.post("/", userController.create);
router.get("/:id", userController.getOne);
router.delete("/:id", userController.delete);
router.put("/:id", userController.update);
router.put("/password/:id", userController.updatePassword);

export default router;
