namespace ToDoList;
public class Tickets : IEquatable<Tickets> 
{
    public required string Title { get; set; }
    public string? Description { get; set; }
    public string? Tag { get; set; }
    public required string TicketId { get; init; }
    public bool Equals(Tickets? other) => other is not null && TicketId == other.TicketId;

    public override bool Equals(object? obj) => Equals(obj as Tickets);
    
    public override int GetHashCode() => HashCode.Combine(TicketId);
    
    public override string ToString() =>
        $"[{TicketId}]{Title} (Tag: {Tag ?? "none"}) (Description: {Description ?? "none"})";
    
}

public class Query
{
    public static void Main()
    {
        List<Tickets> ticket = new List<Tickets>();
        
        ticket.Add( new Tickets() { Title = "Merge issues", TicketId = "123A", Tag="Git", Description = "Cannot merge branch into main."});
        ticket.Add( new Tickets() { Title = "Cannot make a component in Figma", TicketId = "312A", Tag="Figma", Description = "Its purple though without the component icon."});
        ticket.Add( new Tickets() { Title = "Import Component issue", TicketId = "111B", Tag="Astro", Description = "Astro says my component is undefined."});
        ticket.Add( new Tickets() { Title = "Feedback on Portfolio", TicketId = "669T", Tag="Figma", Description = "Feedback on my Figma Portfolio Prototype."});
        
        Console.WriteLine();
        foreach (var pushTicket in ticket)
        {
            Console.WriteLine(pushTicket);
        }
    }
}