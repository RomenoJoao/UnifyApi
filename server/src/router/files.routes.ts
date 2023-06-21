import Router from "express"
import upload from "../middleware/uploadFiles"
import FileController from "../controllers/files.controller"

const router = Router()
const fileController = new FileController()


router.post("/",upload,fileController.uploadFiles)
router.get("/:filename", fileController.getFile);



export default router