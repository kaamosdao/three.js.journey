import clsx from 'clsx';
import s from './page.module.scss';

export default function Home() {
  return (
    <main>
      <canvas className={clsx('canvas', s.canvas)} />
    </main>
  );
}
