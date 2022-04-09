import type { NextPage } from 'next'
import Head from 'next/head'
import Image from 'next/image'
import { useState } from 'react'
import Button from '../components/Button'
import SignUpForm from '../components/SignUpForm'
import useDwitter from '../hooks/useDwitter'

export default function Home() {
  const { connect, account, user, createUser, postDweet, dweets} =  useDwitter();
  const [ dweetContent, setDweetContent] = useState<string>('');

  //console.log(user);
  return (
    <div className="flex min-h-screen flex-col items-center justify-center py-2">
      <Head>
        <title>Dwitter</title>
        <link rel="icon" href="/favicon.ico" />
      </Head>

      <main className="flex w-full flex-1 flex-col items-center justify-center px-20 ">
        <h1 className="text-6xl font-bold mb-8">
          Welcome to{' '}
          <span className="text-blue-500">
            Dwitter
          </span>
        </h1>
        { !account ? (
          <Button 
          label="Connect with Ethereum" 
          onClick={ connect } 
          />
          ) : (
          account.toUpperCase()!==user?.wallet.toUpperCase() ? (
            <SignUpForm createUser={createUser} />
          ) : ( 
            <>
            <div className="flex items-center w-80">
              <img src={user?.avatar} className="w-20 h-20 rounded-full mr-4"/>
              <textarea className="rounded-xl ml-4 w-64" placeholder="What's happening?" value={ dweetContent }  onChange={e => setDweetContent(e.target.value)}/>
            </div>
            <div className='mt-2 flex justify-end w-71'>
              <Button  label="Dweet" onClick={()=>postDweet(dweetContent)} />
            </div>
            
            </>
          )
        )}  
        {
          dweets.map(dweet => (
            
            
              
            

            <div className="flex items-center w-80">
            <img src={user?.avatar} className="w-10 h-10 rounded-full mr-4"/>
            <div className="flex flex-col">
              <p className="text-xl font-bold">{dweet.content}</p>
            </div>
          </div>
         
          

          ))
        }
      </main>

      <footer className="flex h-24 w-full items-center justify-center border-t">
        
          Powered by Ethereum
        
        
      </footer>
    </div>
  )
}

//export default Home;
