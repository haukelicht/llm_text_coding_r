library(openai)
Sys.getenv("OPENAI_API_KEY")
MODEL = 'gpt-3.5-turbo-0125'

# simple example: only one text ----
response <- create_chat_completion(
  model = MODEL,
  messages = list(
    list(
      "role" = "system",
      "content" = "Act as a sports expert."
    ),
    list(
      "role" = "user",
      "content" = "Who won the world series in 2020?"
    )
  )
)
str(response)
response$choices$message.content[1]


# advanced example: multiple texts ----

texts <- c(
  "Who won the world series in 2000?",
  "Who won the world series in 2010?",
  "Who won the world series in 2020?",
  "Who won the world series in 2030?"
)

## with a for loop

answers <- character()
for (text in texts) {
  print(text)
  
  # put the logic for querying the model
  response <- create_chat_completion(
    model = MODEL,
    messages = list(
      list(
        "role" = "system",
        "content" = "Act as a sports expert."
      ),
      list(
        "role" = "user",
        "content" = text
      )
    )
  )
  
  answers[text] <- response$choices$message.content[1]
}

unname(answers)

for (text in texts) {
  answers[text] <- custom_prompt_function(text)
}

# reading instructions from an external text file ----

# note: this is a better approach then defining them as a character value in your R script/notebook
instruction <- readr::read_lines("prompts/gilardi_2023-content_moderation_relevance.txt")
instruction <- paste(instruction, collapse = "\n")
cat(instruction)


