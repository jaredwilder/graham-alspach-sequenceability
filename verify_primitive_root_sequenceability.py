#!/usr/bin/env python3
"""Finite replay for the primitive-root full-group sequenceability theorem.

The theorem itself is proved in FULL-NONZERO-GROUP-PRIMITIVE-ROOT-THEOREM.md.
This script is only a computational calibration over all odd primes below 300.
"""
from math import isqrt

LIMIT = 300


def is_prime(n: int) -> bool:
    if n < 2:
        return False
    if n % 2 == 0:
        return n == 2
    d = 3
    while d <= isqrt(n):
        if n % d == 0:
            return False
        d += 2
    return True


def prime_factors(n: int):
    out = set()
    d = 2
    while d * d <= n:
        while n % d == 0:
            out.add(d)
            n //= d
        d += 1
    if n > 1:
        out.add(n)
    return out


def primitive_root(p: int) -> int:
    phi = p - 1
    factors = prime_factors(phi)
    for g in range(2, p):
        if all(pow(g, phi // q, p) != 1 for q in factors):
            return g
    raise RuntimeError(f'no primitive root found mod {p}')


def verify_prime(p: int):
    g = primitive_root(p)
    seq = [pow(g, k, p) for k in range(1, p)]
    assert len(seq) == p - 1
    assert set(seq) == set(range(1, p))

    partial = []
    s = 0
    for x in seq:
        s = (s + x) % p
        partial.append(s)

    # Proper partial sums are nonzero; the full sum is zero.
    assert all(x != 0 for x in partial[:-1]), (p, g, partial)
    assert partial[-1] == 0, (p, g, partial[-1])

    # All p-1 partial sums, including the final 0, are distinct.
    assert len(set(partial)) == p - 1, (p, g)
    return g


primes = [p for p in range(3, LIMIT) if is_prime(p)]
roots = {p: verify_prime(p) for p in primes}

assert len(primes) == 61, len(primes)
assert roots[73] == 5, roots[73]

print('PASS')
print('odd primes checked:', len(primes))
print('range: 3 <= p < 300')
print('least primitive root mod 73:', roots[73])
print('zero failures')
