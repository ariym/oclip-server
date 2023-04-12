# oClip extensions

## Current Working Structure

1. cd /extensions
2. [Add model as git submodule in](https://gist.github.com/gitaarik/8735255)
3. Create modelname.ts file for bindings that conform to oClip extension standards

## Objectives

- extensions are add-on apps that can process files, read/write to db, and provide their own user interfaces.
- \* extensions can require other extensions as dependencies
e.g. a clip generator requires WhisperX and BERT

## Extension Categories

Extensions can fit into more than one category, these are what the extensions hub will offer for easier browsing.

- Vector databases
- Interfaces (html/js served over http)
- LLM

### Default extensions (preinstalled)

- watch session history -> creates and saves table of every timestamp clicked too and watched (grouped by session) (enables back/forward button behavoir like in a browser)

### Clip generators

- debate: have 2 speakers that are authorities on a topic debate one another using source material
- topic-hop: start with a topic and whenever a new tangent/topic is mentioned cut to the speaker talking about it on another show

### Machine learning extensions

- whisperx: transcriber
- mediapipe motion tracker: object tagging, action description
- bert summarizer -> transcript: generarate clip titles, descriptions, synonpsis, and summary
- coqui: voice cloning, narration

### Try out these

- <https://github.com/NVlabs/prismer>
- <https://github.com/m-bain/whisperX>
- <https://github.com/mharrvic/semantic-search-openai-pinecone>
- <https://github.com/jankais3r/Video-Depthify>
- <https://github.com/adap/flower>
- <https://github.com/tantaraio/voy>
- [Chrome extension - reddit comments on youtube videos](https://github.com/odensc/karamel)
- <https://github.com/google/mediapipe>
- <https://github.com/ggerganov/llama.cpp>
- <https://github.com/coqui-ai/TTS>
- <https://huggingface.co/bert-base-uncased>
- <https://huggingface.co/Seethal/sentiment_analysis_generic_dataset?text=hey+hows+it+going>
- <https://github.com/facebookresearch/segment-anything>
