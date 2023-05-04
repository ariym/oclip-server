import express, { Request, Response, Next } from 'express';
const server = express();
import { submitNewVideoFile } from '../services/Video';
import FileBrowser from '../services/File';

server.post('/video/add-file', async (req: Request, res: Response, next: Next) => {
  try {

    const savedVideo = await submitNewVideoFile(req.body.submission);

    // todo: user-settings check for running processing apps and order to run in (if any)
    let isProcessing = false
    // if(settings.submissionProcessingApps.length > 0) {
    //   intiateProcessing(savedVideo);
    //   isProcessing = true;
    // }

    res.json({message:"video saved!", savedVideo, isProcessing});

  } catch (error) {
    next(error)
  }
});

server.post("/fs/read", async (req: Request, res: Response, next: Next) => {
  try {

    const browser = new FileBrowser(req.body.path);
    const dir = await browser.readDir();
    res.json(dir);

  } catch (error) {
    next(error);
  }
});

export default server;