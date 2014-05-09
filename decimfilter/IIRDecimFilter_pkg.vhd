-- -------------------------------------------------------------
-- 
-- File Name: Q:\Users\Qlab\Documents\Blake\iirfilter\hdlsrc\polyphaseIIR\IIRDecimFilter_pkg.vhd
-- Created: 2014-05-09 14:18:25
-- 
-- Generated by MATLAB 8.3 and HDL Coder 3.4
-- 
-- -------------------------------------------------------------


LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;

PACKAGE IIRDecimFilter_pkg IS
  TYPE vector_of_signed13 IS ARRAY (NATURAL RANGE <>) OF signed(12 DOWNTO 0);
  TYPE vector_of_signed14 IS ARRAY (NATURAL RANGE <>) OF signed(13 DOWNTO 0);
  TYPE vector_of_signed15 IS ARRAY (NATURAL RANGE <>) OF signed(14 DOWNTO 0);
END IIRDecimFilter_pkg;
