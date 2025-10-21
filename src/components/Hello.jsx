import React from 'react';

export default function Hello({ name = 'Mundo' }) {
  const [count, setCount] = React.useState(0);

  return (
    <div>
      <p>Hola {name} — contador: {count}</p>
      <button onClick={() => setCount(c => c + 1)}>Incrementar</button>
    </div>
  );
}
