import Router, { Request, Response } from "express";
import UserController from "../controllers/user.controller";

const router = Router();

const userController = new UserController();

router.get("/", userController.getAll);
router.post("/", userController.create);

export default router;
