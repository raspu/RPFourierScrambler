//
//  FourierScrambler.swift
//  FourierScrambler
//
//  Created by Juan Pablo Illanes Sotta on 13/8/15.
//  Copyright (c) 2015 RaspuBox inc. All rights reserved.
//

import Foundation

/// Helper class for generating fourier scramble arrays.
public class FourierScrambler
{
    /**
    Generates a new Scramble Array with the given size, using the given amount of iterations. If it wasn't possible to generate a valid array will return nil. The time complexity of this method is O(arraySize*iterations).
    
    :param: arraySize  The desired size for the array. Results are not guaranteed for an odd arraySize.
    :param: iterations The desired number of iterations.
    
    :returns: An array that can be used to scramble another array.
    */
    class public func generateScrambleArrayOfSize(arraySize: Int, iterations: Int) -> [Int]?
    {
        if(Int(roundf(log2(Float(arraySize)))) <= iterations)
        {
            return nil
        }
        
        var a = [Int](count: arraySize, repeatedValue:-1)
        var b = [Int](count: arraySize, repeatedValue:-1)
        var sum = 0;
        
        for (var i = 0; i < count(a); i++ )
        {
            var index = newPosAfterIteration(i,length: count(a), iteration: iterations)
            a[index] = i
            b[index] += 1
            
            if(b[index] > 0)
            {
                return nil
            }
        }
        
        return a;
    }
    
    
    /**
    Will generate a string that can be used as a hard-coded array in swift.
    
    :param: array Array of numbers.
    */
    class public func printSwiftArray(array: [Int]) -> Void
    {
        print("[")
        for (var i = 0; i < count(array); i++ )
        {
            if (i != 0)
            {
                print(",")
            }
            print(array[i])
        }
        print("]")
    }
    
    /**
    Will generate a string that can be used as a hard-coded array in C/C++.
    
    :param: array Array of numbers
    :param: named Name to use for the array
    */
    class public func printCArray(array: [Int], named: String) -> Void
    {
        for (var i = 0; i < count(array); i++ )
        {
            println("\(named)[\(i)] = \(array[i]).0;")
        }
    }
    

    
    /**
    Returns the new position from a given index, for an array with the given length
    
    :param: pos    Original Index
    :param: length Array length
    
    :returns: New position for that index
    */
    class private func newPos (pos: Int, length: Int ) -> Int
    {
        if(pos%2 == 0)
        {
            return pos/2
        }else
        {
            return Int(ceil(Float(length)/Float(2))) + (pos-1)/2
        }
    }
    
    /**
    Returns the new position from a given index, for an array with the given length, after a certain number of iterations
    
    :param: pos    Original Index
    :param: length   Array length
    :param: iteration Number of iterations
    
    :returns: New Position
    */
    class private func newPosAfterIteration (pos: Int, length: Int, iteration: Int) -> Int
    {
        var nPos = pos
        var nLength = length
        var offset = 0
        
        for (var i = 0; i<iteration; i++)
        {
            nPos = newPos(nPos, length: nLength)
            if(nPos >= Int(ceil(Float(nLength)/Float(2))) )
            {
                offset += Int(ceil(Float(nLength)/Float(2)))
                nPos = nPos - Int(ceil(Float(nLength)/Float(2)))
            }
            nLength /= 2
        }
        
        return nPos + offset
    }
    
}
