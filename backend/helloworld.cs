using System;

// vi bruger klasser fra System namespace
// er for at holde struktur & orden på koden. 
// Kan ses som en container for klasser og diverse namespaces
namespace HelloWorld
{
    // class er vores container for data & metoder. 
    // Den giver funktionaliteten til programmet 
    // Koden SKAL være i en klasse for at kunne køre.
    class Text

    {
        // Main er metoden.
        static void Main(string[] args)
        {
            const string name = "Katja";
            const string lastName = "Jacobsen";
            const string fullName = name + lastName;

            const int x = 1, y = 2, z = 100;
            // Console er vores klasse fra System namespace,
            // hvilket indeholdet WriteLine() metoden.
            Console.Write("Hello You!❤️");
            Console.WriteLine(fullName);
            Console.WriteLine(x + y + z);
        }
    }
}


// INSIGHTS

// C# er case sensitive, f.eks. er MyClass & myclass to forskellige betydninger
// Ikke alle C# statements ender nødvendigvis med semicolon.


// C# Variabler 
// int — hele tal
// double — floating point numbers, også kaldt som decimal tal
// char — characters
// string – text
// bool – true eller false

// Identifiers 
// Give variabler et unik navn
// Der anbefales at man bruger beskrivende navne for effektiv
// læsevenlighed og vedligeholdelse

namespace Number
{
    class Number
    {
        static void Main(int[] args)
        {
            int minute = 60;
            double theNumber = 4.32D;
            char Letter = 'D';
            bool amIReal = true;
            string hello = "world"; // kan være sensitiv for brug af ''. Skal være "".
        }
    }
}

// Type Casting 
// Tildeler en data værdi til en anden data type
// Man kan gøre det eksplicit eller implicit

// GET USER

namespace userApi
{
    class getUser
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Enter username:");
            string userName = Console.ReadLine();
            Console.WriteLine("Hello " + userName);
            
        }
    }
}