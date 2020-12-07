using System;
using System.Collections.Generic;

namespace day7{
  class MainClass {
      public static void Main (string[] args) {
          System.IO.StreamReader file = new System.IO.StreamReader(@"input");
          Dictionary<string, Dictionary<string, int>> bags = new Dictionary<string, Dictionary<string, int>>();

          string line;
          string[] w;
          string[] x;

          while((line = file.ReadLine()) != null) {
              w = line.Split(" bags contain ");
              bags[w[0]] = new Dictionary<string, int>();

              if (w[1] != "no other bags.") {
                  foreach(string el in w[1].Split(", ")) {
                      x = el.Split(" ");
                      bags[w[0]][$"{x[1]} {x[2]}"] = Int32.Parse(x[0]);
                  }
              }
          }
          file.Close();

          int count = 0;
          foreach (KeyValuePair<string, Dictionary<string, int>> bag in bags){
              if (searchBags(bag.Key, bags)) {
                  count++;
              }
          }

          System.Console.WriteLine($"Bag count: {count}");
          System.Console.WriteLine($"Total count: {countBags("shiny gold", bags) - 1}");
      }

      private static bool searchBags(string bagType, Dictionary<string, Dictionary<string, int>>bags) {
          foreach (KeyValuePair<string, int> bag in bags[bagType]) {
              if (bag.Key == "shiny gold" || searchBags(bag.Key, bags)) {
                  return true;
              }
          }

          return false;
      }

      private static int countBags(string bagType, Dictionary<string, Dictionary<string, int>>bags) {
          int count = 1;

          foreach (KeyValuePair<string, int> bag in bags[bagType]) {
              // System.Console.WriteLine($"{bag.Key} {bag.Value}");
              for (int i = 0; i < bag.Value; i++) {
                  count += countBags(bag.Key, bags);
                  // System.Console.WriteLine($"{bag.Key}");
              }
          }

          return count;
      }
  }
}