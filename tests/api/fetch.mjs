import http from 'node:http';
import https from 'node:https';
import { URL } from 'node:url';

function makeResponse(status, headers, bodyBuffer) {
  const bodyText = bodyBuffer ? bodyBuffer.toString('utf8') : '';
  return {
    status,
    ok: status >= 200 && status < 300,
    headers,
    text: async () => bodyText,
    json: async () => {
      try { return JSON.parse(bodyText); } catch (e) { return null; }
    }
  };
}

export default function fetch(url, opts = {}) {
  return new Promise((resolve, reject) => {
    try {
      const u = new URL(url);
      const lib = u.protocol === 'https:' ? https : http;
      const body = opts.body ? (typeof opts.body === 'string' ? opts.body : JSON.stringify(opts.body)) : null;
      const headers = opts.headers ? { ...opts.headers } : {};
      if (body && !headers['Content-Length']) headers['Content-Length'] = Buffer.byteLength(body);
      const req = lib.request(u, { method: opts.method || 'GET', headers }, (res) => {
        const chunks = [];
        res.on('data', (c) => chunks.push(c));
        res.on('end', () => {
          const buf = Buffer.concat(chunks);
          resolve(makeResponse(res.statusCode || 0, res.headers, buf));
        });
      });
      req.on('error', reject);
      if (body) req.write(body);
      req.end();
    } catch (err) { reject(err); }
  });
}
