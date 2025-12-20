#!/usr/bin/env node
const { spawn } = require('child_process');

const child = spawn('mcp-mermaid', ['--transport', 'stdio'], {
  env: process.env,
  stdio: ['pipe', 'pipe', 'pipe'],
});

// Filter apenas a linha de banner, preservando demais linhas (mesmo no primeiro chunk).
child.stdout.on('data', (chunk) => {
  const lines = chunk.toString().split(/\r?\n/);
  const filtered = lines
    .filter((line) => line.trim() !== 'STDIO MCP Server started')
    .join('\n');
  if (filtered.length > 0) {
    process.stdout.write(filtered + (chunk.toString().endsWith('\n') ? '' : ''));
  }
});

child.stderr.on('data', (chunk) => process.stderr.write(chunk));
process.stdin.on('data', (chunk) => child.stdin.write(chunk));
process.stdin.on('end', () => child.stdin.end());

child.on('exit', (code, signal) => {
  if (signal) {
    process.kill(process.pid, signal);
  } else {
    process.exit(code ?? 0);
  }
});
