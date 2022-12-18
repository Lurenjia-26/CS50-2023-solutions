#include <cs50.h>
#include <stdio.h>
#include <ctype.h>
#include <string.h>

int count_letters(string text);
int count_words(string text);
int count_sentences(string text);

int main(void)
{
    int letters, words, sentences;
    float result;
    string text = get_string("Text: ");

    letters = count_letters(text);
    words = count_words(text);
    sentences = count_sentences(text);
    result = 

    printf("Grade %.0f\n", result);
}

int count_letters(string text)
{
    int count = 0;
    for (int i = 0; i < strlen(text); i++)
    {
        if (isalnum(text[i]))
            count++;
    }
    return count;
}

int count_words(string text)
{
    int count = 0;
    char pre_letter = ' ';

    for (int i = 0; i < strlen(text); i++)
    {
        if (isalnum(text[i]) && isspace(pre_letter))
            count++;
        pre_letter = text[i];
    }
    return count;
}

int count_sentences(string text)
{
    int count = 0;
    for (int i = 0; i < strlen(text); i++)
    {
        if (ispunct(text[i]) && (text[i] == '.' || text[i] == '!' || text[i] == '?'))
            count++;
    }
    return count;
}