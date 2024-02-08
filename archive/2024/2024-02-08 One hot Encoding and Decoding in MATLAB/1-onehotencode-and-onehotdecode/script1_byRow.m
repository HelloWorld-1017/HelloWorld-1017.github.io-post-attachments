clc,clear,close all

% One-hot encoding: conversion from "category" labels to "one-hot" labels
colorsOriginal = ["red","blue","red","green","yellow","blue"];
colorsOriginal = categorical(colorsOriginal);
classes = categories(colorsOriginal);
colorsEncoded = onehotencode(colorsOriginal,1);

% One-hot decoding: conversion from "one-hot" labels to "category" labels
colorsDecoded = onehotdecode(colorsEncoded,classes,1);