clc,clear,close all

connection = fred("https://research.stlouisfed.org/fred2/");
s = fetch(connection,"WTB6MS");
close(connection)