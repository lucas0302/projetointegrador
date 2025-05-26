import app, { init } from './app';

const port = process.env.PORT ? +process.env.PORT : 5001;

init().then(() => {
  app.listen(port, () => {
    /* eslint-disable-next-line no-console */
    console.log(`Server is listening on port ${port}.`);
  }); 
});
 