import { cleanFormattingResidue } from "./mod.ts";

function assertEquals(actual: unknown, expected: unknown): void {
  if (actual !== expected) throw new Error(`expected ${expected}, got ${actual}`);
}

function assertThrows(callback: () => void, errorType: new (...args: never[]) => Error): void {
  try {
    callback();
  } catch (error) {
    if (error instanceof errorType) return;
    throw error;
  }
  throw new Error("expected callback to throw");
}

function runSmokeTests(): void {
  assertEquals(
    cleanFormattingResidue("<p>Hello <span>world</span>…</p><div>Next line</div>"),
    "Hello world...\n\nNext line",
  );
  assertThrows(() => cleanFormattingResidue(null as unknown as string), TypeError);
}

const runtime = globalThis as typeof globalThis & {
  Deno?: { test(name: string, callback: () => void): void };
};

if (runtime.Deno) {
  runtime.Deno.test("cleans copied formatting residue", runSmokeTests);
} else {
  runSmokeTests();
}
