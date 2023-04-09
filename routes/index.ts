import express, { Request, Response, Next } from 'express';
const server = express();
import { submitNewVideoFile } from '../services/Video';


server.post('/submit', async (req: Request, res: Response, next: Next) => {
  try {

    const { submission } = req.body; // url or path

    const savedVideo = await submitNewVideoFile(submission);

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


export default server;