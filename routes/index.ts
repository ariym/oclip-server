import express, { Request, Response, Next } from 'express';
import { submitVideo } from '../models/Video';
const server = express();


server.post('/submit/video', async (req: Request, res: Response, next: Next) => {
  try {

    const { submission } = req.body; // url or path

    const savedVideo = await submitVideo(submission);

    // todo: user-settings check for running processing apps and order to run in (if any)

    res.json({message:"video saved!", savedVideo});

  } catch (error) {
    next(error)
  }
});


export default server;