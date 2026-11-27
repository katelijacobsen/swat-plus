const Card = () => {
    return (
        <section className="h-fit bg-blue-300 rounded-md px-6 py-4 grid grid-cols-[2fr_1fr] grid-rows-[1fr_2fr_1fr]">
            <h2 className="col-span-full">Tutor på vagt</h2>
            <div className="w-24 aspect-square col-start-2 row-start-2 bg-blue-500 justify-end">Icon</div>
            <p className="col-span-full row-start-2 row-end-4 self-end text-6xl">2</p>
        </section>
    );
}

export default Card;