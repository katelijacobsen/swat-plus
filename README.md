# swat-plus

## Install guide til C#

## STEP 1 — installere .NET (Mac)
brew install --cask dotnet-sdk

### For at check om det er blevet installeret
dotnet --list-sdks

## STEP 2 — Installere C# Extension for VSC
code --install-extension ms-dotnettools.csdevkit

Extension giver snippets, debug og highlighting

## STEP 3 — Test
Opret en fil (test.cs) med linje Console.WriteLine('Hello World');

kør koden i terminalen med kommandoen:
dotnet run file.cs