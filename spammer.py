import discord
from discord.ext import commands, tasks
import asyncio

# Intents are required to enable certain functionalities
intents = discord.Intents.default()
intents.typing = False
intents.presences = False
intents.messages = True

# Prompt for bot token, guild name, and bot name
TOKEN = input("Enter your bot token: ")
GUILD_NAME = input("Enter your guild name: ")
BOT_NAME = input("Enter your bot's name: ")

bot = commands.Bot(command_prefix='/', intents=intents)

@bot.event
async def on_ready():
    print(f'Logged in as {bot.user} (ID: {bot.user.id})')
    for guild in bot.guilds:
        if guild.name == GUILD_NAME:
            print(f'Connected to guild: {guild.name} (ID: {guild.id})')
            break
    else:
        print(f'Guild "{GUILD_NAME}" not found. Exiting...')
        await bot.close()

@bot.command(name='spam')
async def spam(ctx, message: str, repeat: int, cooldown: float):
    if ctx.guild.name != GUILD_NAME:
        await ctx.send("This command can only be used in the specified guild.")
        return

    if ctx.author.name != BOT_NAME:
        await ctx.send("This command can only be used by the specified bot.")
        return

    await ctx.send(f'Spamming message "{message}" {repeat} times with {cooldown} seconds cooldown.')
    for _ in range(repeat):
        await ctx.send(message)
        await asyncio.sleep(cooldown)

bot.run(TOKEN)
