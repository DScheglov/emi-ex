defmodule EMITest do
  use ExUnit.Case
  doctest EMI

  test "2 flows" do
    irr = EMI.irr([-100, 105])
    assert abs(irr - 0.05) < 1.0e-6
  end

  test "6 flows with high accurancy" do
    r = 0.1236589354 / 12
    s = 100
    n = 5
    p = s * r / (1 - :math.pow(1 + r, -n))
    irr = EMI.irr([-s, p, p, p, p, p], 1.0e-9)
    assert abs(irr - r) < 1.0e-9
  end

end
